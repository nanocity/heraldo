module TournamentsHelper
  def subscription_label( status )
    classes = { pending: 'warning', confirmed: 'info', banned: 'danger' }
    content_tag( :span, class: "label label-#{classes[status]}" ) do
      t( "mongoid.attributes.subscription.statuses.#{status}" ).capitalize
    end
  end
end
