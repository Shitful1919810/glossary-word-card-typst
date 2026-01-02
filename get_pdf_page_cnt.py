import argparse
import fitz


def pdf_page_cnt(path: str):
    src = fitz.open(path)
    return src.page_count


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Get page count of a PDF file")
    parser.add_argument("--input", type=str, help="Path to the PDF file")
    args = parser.parse_args()
    print(pdf_page_cnt(args.input))
