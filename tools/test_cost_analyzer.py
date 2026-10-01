import json
import unittest
from pathlib import Path
from cost_analyzer import analyze

ROOT = Path(__file__).resolve().parent.parent

class AnalyzerTests(unittest.TestCase):
    def test_sample_classification_and_totals(self):
        data = json.loads((ROOT / "examples/resources.json").read_text())
        self.assertEqual(data["data_classification"], "ILLUSTRATIVE_SAMPLE_NOT_AWS_BILL")
        self.assertEqual(sum(r["monthly_cost"] for r in data["resources"]), 812)
        self.assertEqual(sum(r["candidate_monthly_cost"] for r in data["resources"]), 544)

    def test_unlabelled_data_rejected(self):
        with self.assertRaises(ValueError):
            analyze({"resources":[]})

if __name__ == "__main__":
    unittest.main()
