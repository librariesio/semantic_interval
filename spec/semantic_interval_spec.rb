require 'spec_helper'

describe SemanticInterval do
  it 'has a version number' do
    expect(SemanticInterval::VERSION).not_to be nil
  end

  it 'should parse interval ranges' do
    expect(SemanticInterval.parse('[1.0,3.0)')).to eq(">= 1.0 < 3.0")
    expect(SemanticInterval.parse('[1.0,3.0]')).to eq(">= 1.0 <= 3.0")
    expect(SemanticInterval.parse('(1.0,3.0)')).to eq("> 1.0 < 3.0")
    expect(SemanticInterval.parse('(,1.0]')).to eq("<= 1.0")
    expect(SemanticInterval.parse('(,1.0)')).to eq("< 1.0")
    expect(SemanticInterval.parse('[1.0,)')).to eq(">= 1.0")
    expect(SemanticInterval.parse('(1.0,)')).to eq("> 1.0")
    expect(SemanticInterval.parse('1.0')).to eq(">= 1.0")
    expect(SemanticInterval.parse('[1.0]')).to eq("1.0")
  end

  it 'should handle multiple ranges correctly' do
    expect(SemanticInterval.parse('(,1.0],[1.2,)')).to eq("<= 1.0 || >= 1.2")
    expect(SemanticInterval.parse('(,1.1),(1.1,)')).to eq("< 1.1 || > 1.1")
  end
end
