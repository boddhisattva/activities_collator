# frozen_string_literal: true

module ParserWithoutParsingMethodsHtmlHelper
  module_function

  def events_content
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
    PAGE_CONTENT
  end
end
