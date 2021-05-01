require 'pry'

# P118
class Book
  def lend_to(user)
    puts "Landing to #{user}"
  end

  def title(title)
    puts "Book title is: #{title}"
  end

  # 回答 24行的問題
  # 當new 的時候就會建立出這個虛擬方法，但實際上呼叫時，會再進去下面的 define_method 去執行
  # 用 define_method 建立的，運行時就會進 define_method
  # def GetTitle
  # 
  # end

  def self.deprecate(old_method, new_method)
    binding.pry
    define_method(old_method) do |*args, &block|
      # 在呼叫舊方法時，才會進來這裡
      # 為什麼??
      binding.pry
      # 這個 warn 跟 Rails.log('xxxx') 作用差不多?
      warn "Warning: #{old_method}() is deprecated. Use #{new_method} ()."
      send(new_method, *args, &block) # 呼叫新方法
    end
  end
binding.pry
  deprecate :GetTitle, :title # 在 new 的時候就會呼叫用 define_method 建立舊方法
  deprecate :LEND_TO_USER, :land_to
end

b = Book.new
b.GetTitle('statementdog')
# b.LEND_TO_USER('user')
# b.title('statementdog')
