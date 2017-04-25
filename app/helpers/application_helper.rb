module ApplicationHelper

  def extract_word(string)
    extracted = []
    x = []
    if string.present?
      string.each_line do |l|
        l.scan(regex_email){|email| extracted << email}
        extracted << URI.extract(l, ['http', 'https'])
      end
    end
    extracted.uniq.each{|ex, u| x << ex}
    x
  end

  def regex_email
    /\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/i
  end
end
