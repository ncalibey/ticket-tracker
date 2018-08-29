module TicketsHelper
  def tag_list(ticket)
    if ticket.tags.any?
      ticket.tags.map(&:name).join(', ')
    else
      "-"
    end
  end
end
