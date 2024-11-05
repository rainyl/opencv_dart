import json
import os
import glob
from typing import Dict, Any, Union

ROOT_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

def format_size(size: Union[float, str, dict, None]) -> tuple[str, float]:
    """Format size values with appropriate units and return both display and raw values."""
    try:
        if isinstance(size, (int, float, str)):
            raw_value = float(size) / 1024
            return f"{raw_value:.2f} MB", raw_value
        elif isinstance(size, dict):
            return "N/A (nested)", 0.0
        return "N/A", 0.0
    except Exception as e:
        print(f"Error formatting size: {str(e)}")
        return "Error", 0.0


def process_platform_data(data: Dict[str, Any]) -> Dict[str, Any]:
    """Process and validate platform-specific data."""
    if not isinstance(data, dict):
        print(f"Unexpected type: {type(data).__name__} for data: {data}")
        return {}

    processed = {}
    for key, value in data.items():
        if isinstance(value, dict):
            # Extract total_size and package_size directly for better structure
            processed[key] = {
                "total_size": format_size(value.get("total_size"))[0],
                "package_size": format_size(value.get("package_size"))[0],
            }
        elif isinstance(value, (int, float, str)):
            processed[key] = format_size(value)[0]
        else:
            processed[key] = "N/A"
    return processed


def consolidate_data(reports: list) -> Dict[str, Any]:
    """Consolidate all report data with additional analytics."""
    combined = {}

    for report_path in reports:
        platform = os.path.basename(report_path).replace("_size_report.json", "")
        try:
            with open(report_path) as f:
                data = json.load(f)
                for package, sizes in data.items():
                    if (
                        package == "base_size" or package == "platform" or platform.lower() == "macos_arm"
                    ):  # Skip platform mapping
                        continue
                    if package not in combined:
                        combined[package] = {}
                    if sizes is isinstance(sizes, str):
                        continue
                    combined[package][platform] = process_platform_data(sizes)

        except Exception as e:
            print(f"Error processing {report_path}: {str(e)}")
            continue

    return combined


def main():
    try:
        reports = glob.glob(f"{ROOT_DIR}/size-reports/*/*.json")
        if not reports:
            raise Exception(f"No report files found in {ROOT_DIR}/size-reports")

        combined_data = consolidate_data(reports)

        with open(f"{ROOT_DIR}/combined_size_report.json", "w") as f:
            json.dump(combined_data, f, indent=2)

        print("::set-output name=status::success")
        print(f"::set-output name=report_count::{len(reports)}")

    except Exception as e:
        print(f"::error::Error generating combined report: {str(e)}")
        print("::set-output name=status::failure")
        raise


if __name__ == "__main__":
    main()
