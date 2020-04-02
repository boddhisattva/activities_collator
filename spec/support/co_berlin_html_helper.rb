# frozen_string_literal: true

module CoBerlinHtmlHelper
  module_function

  def events_with_start_and_finish_date_content
    <<-PAGE_CONTENT
      <div class="seite-c-single">
        <a href="/en/current-exhibition-co-berlin">
          <div class="calender-image"><img typeof="foaf:Image" src="https://www.co-berlin.org/sites/default/files/styles/calender/public/article/headerimages/mccartney_artikelbild_website_1.jpg?itok=EFGytvsB" width="1440" height="960" alt="" /></div>
          <div class="calender-text">
            <div class="article-over-title">
              <span class="article-category">News</span>
              <span class="article-date">
                <div class="date-display-range"><span class="date-display-start" property="dc:date" datatype="xsd:dateTime" content="2019-12-07T00:00:00+01:00">07/12/19</span> to <span class="date-display-end" property="dc:date" datatype="xsd:dateTime" content="2020-06-07T00:00:00+02:00">07/06/20</span></div>
              </span>
            </div>
            <div class="article-title">Current exhibitions at C/O Berlin</div>
            <div class="article-subtitle">on view until June 06</div>
            <div class="article-text">Linda McCartney . The Polaroid Diaries<br />Francesca Woodman . On Being an Angel<br />Sophie Thun . Extension<br /><br />Accompanying program<br />Ticket 10/6 euros<br />Guided tours Saturday and Sunday 2 pm and 4 pm (German) . 6 pm (English)</div>
            <div class="more">
        <a href="/en/current-exhibition-co-berlin" title="Current exhibitions at C/O Berlin">more</a></div></div>
        </a>
      </div>
      <div class="seite-c-single">
        <a href="/en/exhibitions/linda-mccartney">
          <div class="calender-image">
            <img typeof="foaf:Image" src="https://www.co-berlin.org/sites/default/files/styles/calender/public/article/headerimages/mccartney_artikelbild_website.jpg?itok=RWp0US4M" width="1440" height="960" alt="" />
            <div class="copyright">
              London, England, 1970s © Paul McCartney / Photographer: Linda McCartney
            </div>
          </div>
          <div class="calender-text">
            <div class="article-over-title">
              <span class="article-category">Exhibitions</span>
              <span class="article-date">
                <div class="date-display-range"><span class="date-display-start" property="dc:date" datatype="xsd:dateTime" content="2020-03-07T00:00:00+01:00">07/03/20</span> to <span class="date-display-end" property="dc:date" datatype="xsd:dateTime" content="2020-06-06T00:00:00+02:00">06/06/20</span></div>
              </span>
            </div>
            <div class="article-title">Linda McCartney</div>
            <div class="article-subtitle">The Polaroid Diaries</div>
            <div class="article-text">From Saturday, 14/03/2020 we are closed due to the Coronavirus. More information.<br /><br /> Public Guided Tours . Sat + Sun and holidays . 2:00 p.m. + 4:00 p.m. (German) . 6:00 p.m. (English)<br /><br /> “She ́d always just be looking for everyday moments that interested her rather than manicured scenes. She wanted real moments.” – Mary McCartney <br /><br /> A man stands in front of a modish...</div>
            <div class="more">
        <a href="/en/exhibitions/linda-mccartney" title="Linda McCartney">more</a></div></div>
        </a>
      </div>
    PAGE_CONTENT
  end

  def event_with_start_date_content
    <<-PAGE_CONTENT
      <div class="seite-c-single">
        <a href="/en/events/lecture-abigail-solomon-godeau">
            <div class="calender-image">
              <img typeof="foaf:Image" src="https://www.co-berlin.org/sites/default/files/styles/calender/public/article/headerimages/woodman_website_lecture.jpg?itok=qHWbqRfC" width="1400" height="960" alt="" />
              <div class="copyright">
                  © C/O Berlin Foundation . naroska design
              </div>
            </div>
            <div class="calender-text">
              <div class="article-over-title"><span class="article-category">Events</span> <span class="article-date"><span class="date-display-single" property="dc:date" datatype="xsd:dateTime" content="2020-03-26T00:00:00+01:00">26/03/20</span></span></div>
              <div class="article-title">Cancelled – Lecture</div>
              <div class="article-subtitle">With Abigail Solomon-Godeau</div>
              <div class="article-text">Time 19:00<br /> With Abigail Solomon-Godeau . Art historian<br /> Language English<br /> Tickets 10/6 euros (incl. exhibition)<br /> <br /> How has the role of women in the art world evolved since the 1970s? How have discourses about the feminine in art changed over the last few decades? How can Francesca Woodman’s work be understood today? What explains Woodman’s enormous and enduring influence...</div>
              <div class="more">
        <a href="/en/events/lecture-abigail-solomon-godeau" title="Cancelled – Lecture">more</a></div></div>
        </a>
      </div>
    PAGE_CONTENT
  end

  def duplicate_events
    <<-PAGE_CONTENT
    <div class="seite-c-single">
      <a href="/en/current-exhibition-co-berlin">
        <div class="calender-image"><img typeof="foaf:Image" src="https://www.co-berlin.org/sites/default/files/styles/calender/public/article/headerimages/mccartney_artikelbild_website_1.jpg?itok=EFGytvsB" width="1440" height="960" alt="" /></div>
        <div class="calender-text">
          <div class="article-over-title">
            <span class="article-category">News</span>
            <span class="article-date">
              <div class="date-display-range"><span class="date-display-start" property="dc:date" datatype="xsd:dateTime" content="2019-12-07T00:00:00+01:00">07/12/19</span> to <span class="date-display-end" property="dc:date" datatype="xsd:dateTime" content="2020-06-07T00:00:00+02:00">07/06/20</span></div>
            </span>
          </div>
          <div class="article-title">Current exhibitions at C/O Berlin</div>
          <div class="article-subtitle">on view until June 06</div>
          <div class="article-text">Linda McCartney . The Polaroid Diaries<br />Francesca Woodman . On Being an Angel<br />Sophie Thun . Extension<br /><br />Accompanying program<br />Ticket 10/6 euros<br />Guided tours Saturday and Sunday 2 pm and 4 pm (German) . 6 pm (English)</div>
          <div class="more">
      <a href="/en/current-exhibition-co-berlin" title="Current exhibitions at C/O Berlin">more</a></div></div>
      </a>
    </div>
    <div class="seite-c-single">
      <a href="/en/current-exhibition-co-berlin">
        <div class="calender-image"><img typeof="foaf:Image" src="https://www.co-berlin.org/sites/default/files/styles/calender/public/article/headerimages/mccartney_artikelbild_website_1.jpg?itok=EFGytvsB" width="1440" height="960" alt="" /></div>
        <div class="calender-text">
          <div class="article-over-title">
            <span class="article-category">News</span>
            <span class="article-date">
              <div class="date-display-range"><span class="date-display-start" property="dc:date" datatype="xsd:dateTime" content="2019-12-07T00:00:00+01:00">07/12/19</span> to <span class="date-display-end" property="dc:date" datatype="xsd:dateTime" content="2020-06-07T00:00:00+02:00">07/06/20</span></div>
            </span>
          </div>
          <div class="article-title">Current exhibitions at C/O Berlin</div>
          <div class="article-subtitle">on view until June 06</div>
          <div class="article-text">Linda McCartney . The Polaroid Diaries<br />Francesca Woodman . On Being an Angel<br />Sophie Thun . Extension<br /><br />Accompanying program<br />Ticket 10/6 euros<br />Guided tours Saturday and Sunday 2 pm and 4 pm (German) . 6 pm (English)</div>
          <div class="more">
      <a href="/en/current-exhibition-co-berlin" title="Current exhibitions at C/O Berlin">more</a></div></div>
      </a>
    </div>
    PAGE_CONTENT
  end
end
