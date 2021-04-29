import unittest
from unittest import TestCase

from cat.main import solution


class TestCatSolution(TestCase):
    def test_example_one(self):
        res = solution([8, 6, 2, 5])
        self.assertEqual(res, 3)

    def test_example_two(self):
        res = solution([9, 7, 7, 10, 4, 8])
        self.assertEqual(res, 4)

    def test_max_val_not_optimum(self):
        res = solution([1, 2, 3, 4, 5, 4, 3, 2, 9, 8, 10, 9])
        self.assertEqual(res, 8)

    def test_no_stop_outer_bound(self):
        res = solution([9, 1, 2, 3, 4, 5, 4, 3, 2])
        self.assertEqual(res, 8)

    def test_no_stop_inner_bound(self):
        res = solution([1, 2, 3, 4, 5, 4, 3, 2, 9])
        self.assertEqual(res, 8)


if __name__ == '__main__':
    unittest.main()