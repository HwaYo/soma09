module PostHelper
  def options_for_max_participant_select
    scope = 2.upto(20)
    list = scope.collect{|number| ["#{number}명", number]}

    options_for_select(list)
  end
end
