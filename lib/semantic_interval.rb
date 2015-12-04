require "semantic_interval/version"

module SemanticInterval
  def self.parse(range)
    parts = range[1..-2].split(',')
    requirements = []
    low_bound = range[0]
    high_bound = range[-1]
    low_number = parts[0].strip
    high_number = parts[1].strip if parts[1]

    # lowest
    low_sign = low_bound == '[' ? '>=' : '>'
    high_sign = high_bound == ']' ? '<=' : '<'

    # highest
    if high_number
      if high_number != low_number
        requirements << "#{low_sign} #{low_number}" if low_number && !low_number.empty?
        requirements << "#{high_sign} #{high_number}" if high_number && !high_number.empty?
      elsif high_number == low_number
        requirements << "= #{high_number}"
      end
    else
      requirements << "#{low_sign} #{low_number}" if low_number && !low_number.empty?
    end
    requirements << '>= 0' if requirements.empty?
    requirements.join(' ')
  end
end
