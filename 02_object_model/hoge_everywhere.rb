# 次に挙げるクラスのいかなるインスタンスからも、hogeメソッドが呼び出せる
# それらのhogeメソッドは、全て"hoge"という文字列を返す
# - String
# - Integer
# - Numeric
# - Class
# - Hash
# - TrueClass

module HogeHoge
  def hoge
    'hoge'
  end
end

%w[String Integer Numeric Class Hash TrueClass].each do |klass|
  Object.module_eval(klass).send(:include, HogeHoge)
end
