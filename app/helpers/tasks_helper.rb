module TasksHelper

  def show_level level
    if level === 'highest'
      return '<svg title="Highest" fill="none" stroke="red" height="20" stroke-width="1.5" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
              <title>Highest</title>
                <path stroke-linecap="round" stroke-linejoin="round" d="M8.25 6.75L12 3m0 0l3.75 3.75M12 3v18"></path>
              </svg>'
    elsif level === 'high'
      return '<svg title="High" fill="none" stroke="red" height="20" stroke-width="1.5" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
              <title>High</title>
              <path stroke-linecap="round" stroke-linejoin="round" d="M4.5 19.5l15-15m0 0H8.25m11.25 0v11.25"></path>
            </svg>'
    elsif level === 'medium'
      return '<svg title="Medium" fill="none" stroke="orange" height="20" stroke-width="1.5" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
              <title>Medium</title>
              <path stroke-linecap="round" stroke-linejoin="round" d="M13.5 4.5L21 12m0 0l-7.5 7.5M21 12H3"></path>
            </svg>'
    else
      return '<svg title="Low" fill="none" stroke="orange" height="20" stroke-width="1.5" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
              <title>Low</title>
              <path stroke-linecap="round" stroke-linejoin="round" d="M4.5 4.5l15 15m0 0V8.25m0 11.25H8.25"></path>
            </svg>'
    end
  end
end