class String
  ACCENTS = { 
    ['á','à','â','ä','ã'] => 'a',
    ['Ã','Ä','Â','À','Á'] => 'A',
    ['é','è','ê','ë'] => 'e',
    ['Ë','É','È','Ê'] => 'E',
    ['í','ì','î','ï'] => 'i',
    ['Í','Î','Ì','Ï'] => 'I',
    ['ó','ò','ô','ö','õ'] => 'o',
    ['Õ','Ö','Ô','Ò','Ó'] => 'O',
    ['ú','ù','û','ü'] => 'u',
    ['Ú','Û','Ù','Ü'] => 'U',
    ['ç'] => 'c', ['Ç'] => 'C',
    ['ñ'] => 'n', ['Ñ'] => 'N'
  }

  SPECIAL_CHARS = ["\\","^","-","]"] # Any character except \^-] add that character to the possible matches. 

  def slugfy_words
    r = ""
    self.split(/\s+/).each do |e|
      r << e.slugfy(:allow_chars => "-_.")
    end
    return r
  end

  def slugfy(options = {})
    str = self
    allow_chars = options[:allow_chars] || "" 
    deny_chars = options[:deny_chars] || "" 
    space = options[:space] || "-"

    ACCENTS.each do |ac,rep|
      ac.each do |s|
        str = str.gsub(s, rep)
      end
    end

    SPECIAL_CHARS.each do |s|
      allow_char = allow_chars.gsub(s, "\\#{s}")
      deny_char  = deny_chars.gsub(s, "\\#{s}")
    end

    str = str.gsub(/[^a-zA-Z0-9 #{allow_chars}]/,"")
    str = str.gsub(/[#{deny_chars}]/,"") unless deny_chars.empty?
    str = str.gsub(/[ ]+/," ")
    str = str.gsub(/ /,space)

    str = str.downcase
  end

  def boo_slugfy
    str = self
    ACCENTS.each do |ac,rep|
      ac.each do |s|
        str = str.gsub(s, rep)
      end
    end

    str = str.gsub(/[^a-zA-Z0-9 +-]/,"")
    str = str.gsub(/[ ]+/," ")
    str = str.gsub(/[-]+/,"-")
    str = str.gsub(/[+]+/,"+")

    str = str.downcase
  end

  def filename_slugfy
    str = self
    ACCENTS.each do |ac,rep|
      ac.each do |s|
        str = str.gsub(s, rep)
      end
    end

    str = str.gsub(/[^.a-zA-Z0-9 ]/,"")
    str = str.gsub(/[ ]+/," ")
    str = str.gsub(/ /,"-")

    str = str.downcase
  end

end
