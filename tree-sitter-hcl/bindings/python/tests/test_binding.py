from unittest import TestCase

import tree_sitter
import tree_sitter_hcl_ng


class TestLanguage(TestCase):
    def test_can_load_grammar(self):
        try:
            tree_sitter.Language(tree_sitter_hcl_ng.language())
        except Exception:
            self.fail("Error loading HCL grammar")
