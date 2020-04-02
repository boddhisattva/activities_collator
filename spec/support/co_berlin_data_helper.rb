# frozen_string_literal: true

module CoBerlinDataHelper
  module_function

  def first_event_with_start_and_finish_date_description
    'Linda McCartney . The Polaroid DiariesFrancesca Woodman . On Being an AngelSophie Thun . ' \
    'ExtensionAccompanying programTicket 10/6 eurosGuided tours Saturday and Sunday 2 pm and 4 pm (German) . 6 pm (English)'
  end

  def second_event_with_start_and_finish_date_description
    'From Saturday, 14/03/2020 we are closed due to the Coronavirus. More information. Public Guided Tours . ' \
    'Sat + Sun and holidays . 2:00 p.m. + 4:00 p.m. (German) . 6:00 p.m. (English) “She ́d always just be looking ' \
    'for everyday moments that interested her rather than manicured scenes. She wanted real moments.” – Mary McCartney' \
    '  A man stands in front of a modish...'
  end

  def event_with_start_date_description
    'Time 19:00 With Abigail Solomon-Godeau . Art historian Language English Tickets 10/6 euros (incl. exhibition) ' \
    ' How has the role of women in the art world evolved since the 1970s? How have discourses about the feminine in art ' \
    'changed over the last few decades? How can Francesca Woodman’s work be understood today? What explains Woodman’s enormous' \
    ' and enduring influence...'
  end

  def events_info
    [{ title: 'Current exhibitions at C/O Berlin',
       description: first_event_with_start_and_finish_date_description,
       start: Date.parse('Sat, 07 Dec 2019'),
       finish: Date.parse('Sat, 07 Jun 2020'),
       url: 'https://www.co-berlin.org/en/calender/en/current-exhibition-co-berlin' },
     { title: 'Linda McCartney',
       description: second_event_with_start_and_finish_date_description,
       start: Date.parse('Sat, 07 Mar 2020'),
       finish: Date.parse('Sat, 06 Jun 2020'),
       url: 'https://www.co-berlin.org/en/calender/en/exhibitions/linda-mccartney' }]
  end

  def duplicate_events_info; end
end
