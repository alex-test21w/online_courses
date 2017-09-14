module ApplicationHelper
  def wrap_with_h1
    tags = %w[h1 h2 h3 h4 h5 h6]
    html = []
    html << "<div class='content-wrapper'>"
    html << render('layouts/partials/flash_messages')

    if content_for?(:h1_for_wrap)
      html << "<section class='content-header'>"

      html <<
        if tags.any? { |x| content_for(:h1_for_wrap).include?(x) }
          content_for(:h1_for_wrap)
        else
          "<h1 class='pull-left'>#{content_for :h1_for_wrap}</h1>"
        end

      html << '</section>'
    end

    html << "<section class='content'>#{content_for :yield_content}</section>"
    html << '</div>'

    html.join("\n").html_safe
  end

  def status_of_homework(state)
    case state
      when 'approved'
        'states/state_green'
      when 'rejected'
        'states/state_red'
      else
        'states/state_yellow'
    end
  end
end
