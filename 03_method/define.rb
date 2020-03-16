# Q1.
# 次の動作をする A1 class を実装する
# - "//" を返す "//"メソッドが存在すること
class A1
  define_method(:'//') { '//' }
end

# Q2.
# 次の動作をする A2 class を実装する
# - 1. "SmartHR Dev Team"と返すdev_teamメソッドが存在すること
# - 2. initializeに渡した配列に含まれる値に対して、"hoge_" をprefixを付与したメソッドが存在すること
# - 2で定義するメソッドは下記とする
#   - 受け取った引数の回数分、メソッド名を繰り返した文字列を返すこと
#   - 引数がnilの場合は、dev_teamメソッドを呼ぶこと
class A2
  def initialize(args)
    args.each do |arg|
      self.class.send(:define_method, "hoge_#{arg}") do |num|
        return dev_team if num.nil?

        num.to_i.times.map { "hoge_#{arg}" }.join()
      end
    end
  end

  def dev_team
    'SmartHR Dev Team'
  end
end

# Q3.
# 次の動作をする OriginalAccessor モジュール を実装する
# - OriginalAccessorモジュールはincludeされたときのみ、my_attr_accessorメソッドを定義すること
# - my_attr_accessorはgetter/setterに加えて、boolean値を代入した際のみ真偽値判定を行うaccessorと同名の?メソッドができること
module OriginalAccessor
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def my_attr_accessor(method_name)
      define_method(method_name) do
        instance_variable_get("@#{method_name}")
      end

      define_method("#{method_name}=") do |val|
        instance_variable_set("@#{method_name}", val)

        if !!val == val
          questionable!(method_name)
        elsif respond_to?("#{method_name}?")
          self.class.remove_method "#{method_name}?"
        end
      end
    end
  end

  def questionable!(method_name)
    self.class.send(:define_method, "#{method_name}?") do
      !!self.send(method_name)
    end
  end
end
