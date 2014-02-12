class Parser
  TRUTHY = %w(on yes true)
  FALSY = %w(off no false)

  def initialize(filename)
    @lines = []
    File.readlines(filename).each do |line|
      line.delete!(' ')
      line.gsub!("\n", '')
      @lines << line if valid_line?(line)
    end
  end

  def params
    @params ||= to_params(@lines)
  end

  private

  def valid_line?(line)
    line.slice(0) != '#' &&
    line.slice(0) != '=' &&
    line.index('=')
  end

  def set_data_type(value)
    if TRUTHY.include?(value)
      return true
    elsif FALSY.include?(value)
      return false
    end

    to_f_or_i_or_s(value)
  end

  def to_params(lines)
    params = {}
    lines.each do |line|
      key, value = line.split('=')
      params[key.to_sym] = set_data_type(value)
    end

    params
  end

  def to_f_or_i_or_s(value)
    ((float = Float(value)) && (float % 1.0 == 0) ? float.to_i : float) rescue value
  end
end
