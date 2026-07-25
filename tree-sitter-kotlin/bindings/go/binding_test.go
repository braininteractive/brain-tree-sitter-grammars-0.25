package tree_sitter_kotlin_ng_test

import (
	"testing"

	tree_sitter "github.com/tree-sitter/go-tree-sitter"
	tree_sitter_kotlin_ng "github.com/tree-sitter-grammars/tree-sitter-kotlin/bindings/go"
)

func TestCanLoadGrammar(t *testing.T) {
	language := tree_sitter.NewLanguage(tree_sitter_kotlin_ng.Language())
	if language == nil {
		t.Errorf("Error loading Kotlin grammar")
	}
}
