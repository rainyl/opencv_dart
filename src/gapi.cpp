#include "gapi.h"

CvStatus GMat_New_Empty(GMat* rval){
    BEGIN_WRAP
    *rval = new cv::GMat();
    END_WRAP
}

CvStatus GMat_New_FromMat(Mat mat, GMat* rval){
    BEGIN_WRAP
    *rval = new cv::GMat(*mat);
    END_WRAP
}

CvStatus GMat_Close(GMat mat){
    BEGIN_WRAP
    delete mat;
    END_WRAP
}
