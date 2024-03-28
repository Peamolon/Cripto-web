module ApplicationHelper
  def transaction_status_class(status)
    case status
    when 'in_progress', 'not_paid'
      'text-success'
    when 'finished', 'paid'
      'text-danger'
    else
      'text-primary'
    end
  end

end
