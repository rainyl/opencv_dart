import 'package:dartcv4/dartcv.dart' as cv;
import 'package:test/test.dart';

import 'ml_test_data.dart';

/// The cluster of each sample is the same for the first five and for the last five, and differs
/// between the two groups.
void expectClusters(cv.Mat labels) {
  final l = labelsOf(labels);
  expect(l.sublist(0, 5).toSet().length, 1);
  expect(l.sublist(5).toSet().length, 1);
  expect(l[0], isNot(l[5]));
}

cv.EM newEm() => cv.EM.create()..clustersNumber = 2;

void main() {
  test('cv.EM parameters', () {
    final em = cv.EM.create();
    expect(em.defaultName, 'opencv_ml_em');
    expect(em.clustersNumber, cv.EM.DEFAULT_NCLUSTERS);
    expect(em.covarianceMatrixType, cv.EM.COV_MAT_DEFAULT);
    em
      ..clustersNumber = 3
      ..covarianceMatrixType = cv.EM.COV_MAT_SPHERICAL
      ..termCriteria = cv.TermCriteria(cv.TERM_COUNT + cv.TERM_EPS, 50, 1e-4);
    expect(em.clustersNumber, 3);
    expect(em.covarianceMatrixType, cv.EM.COV_MAT_SPHERICAL);
    expect(em.termCriteria.maxCount, 50);
    expect(() => em.clustersNumber = 0, throwsA(isA<cv.CvException>()));
  });

  test('cv.EM trainEM, predict and predict2', () {
    final em = newEm();
    final (ok, logLikelihoods, labels, probs) = em.trainEM(clusterSamples());
    expect(ok, true);
    expect(em.isTrained, true);
    expect(logLikelihoods.rows, 10);
    expect(probs.shape, [10, 2, 1]);
    expectClusters(labels);

    expect(em.means.shape, [2, 2, 1]);
    expect(em.weights.total, 2);
    expect(em.covs.length, 2);

    final cluster0 = labelsOf(labels)[0];
    final (logLikelihood, label, p) = em.predict2(
      cv.Mat.fromList(1, 2, cv.MatType.CV_32FC1, <double>[1.2, 1.3]),
    );
    expect(logLikelihood.isFinite, true);
    expect(label, cluster0);
    expect(p.total, 2);

    // predict returns the posterior probabilities of the components
    final post = em.predict(queryPoints());
    expect(post.shape, [2, 2, 1]);
    expect(post.atNum(0, cluster0), greaterThan(0.5));
  });

  test('cv.EM trainE and trainM', () {
    final means0 = cv.Mat.fromList(2, 2, cv.MatType.CV_64FC1, <double>[1.5, 1.5, 8.5, 8.5]);
    final (okE, _, labelsE, _) = newEm().trainE(clusterSamples(), means0);
    expect(okE, true);
    expectClusters(labelsE);

    // with covs0 and weights0 the components keep the order of means0
    final eye = cv.Mat.eye(2, 2, cv.MatType.CV_64FC1);
    final weights0 = cv.Mat.fromList(1, 2, cv.MatType.CV_64FC1, <double>[0.5, 0.5]);
    final em = newEm();
    final (okE2, _, labelsE2, _) = em.trainE(
      clusterSamples(),
      means0,
      covs0: cv.VecMat.fromList([eye, eye.clone()]),
      weights0: weights0,
    );
    expect(okE2, true);
    expect(labelsOf(labelsE2), clusterLabels);
    expect(em.means.atNum(0, 0), closeTo(1.5, 0.01));

    final probs0 = cv.Mat.fromList(10, 2, cv.MatType.CV_64FC1, [
      for (final l in clusterLabels) ...(l == 0 ? <double>[1, 0] : <double>[0, 1]),
    ]);
    final (okM, _, labelsM, _) = newEm().trainM(clusterSamples(), probs0);
    expect(okM, true);
    expect(labelsOf(labelsM), clusterLabels);
  });

  test('cv.EM save, load and async', () async {
    final em = newEm();
    final (ok, _, labels, _) = await em.trainEMAsync(clusterSamples());
    expect(ok, true);
    expectClusters(labels);

    final sample = cv.Mat.fromList(1, 2, cv.MatType.CV_32FC1, <double>[8.7, 8.1]);
    final (_, label, _) = await em.predict2Async(sample);
    expect(label, em.predict2(sample).$2);

    final path = '${tempDir()}/em.yml';
    em.save(path);
    expect(cv.EM.load(path).predict2(sample).$2, label);

    final means0 = cv.Mat.fromList(2, 2, cv.MatType.CV_64FC1, <double>[1.5, 1.5, 8.5, 8.5]);
    expect((await newEm().trainEAsync(clusterSamples(), means0)).$1, true);
    final probs0 = cv.Mat.fromList(10, 2, cv.MatType.CV_64FC1, [
      for (final l in clusterLabels) ...(l == 0 ? <double>[1, 0] : <double>[0, 1]),
    ]);
    expect(labelsOf((await newEm().trainMAsync(clusterSamples(), probs0)).$3), clusterLabels);
  });

  test('cv.EM errors', () {
    expect(() => cv.EM.create().predict2(queryPoints()), throwsA(isA<cv.CvException>()));
    expect(() => cv.EM.load('/nonexistent/em.yml'), throwsA(isA<cv.CvException>()));
  });
}
