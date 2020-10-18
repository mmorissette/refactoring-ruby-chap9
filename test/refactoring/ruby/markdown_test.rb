require "test_helper"

class Refactoring::Ruby::Chap9Test < Minitest::Test
  def test_markdown_to_html
    fall_time = Time.local(2020, 10, 20)
    Timecop.freeze(fall_time) do
      source = <<~MARKDOWN
      # Heading 1
      Today is **{{today}}** and we are in {{season}}

      ## Heading 2
      Hello my name is *@mmorissette*

      ### Heading 3
      Third paragraph with **bold1** and **bold2**
      MARKDOWN

      md = ::Markdown.new(source, replace_usernames: true)

      expected_html = <<~HTML
      <h1>Heading 1</h1>
      <p>Today is <b>2020-10-20</b> and we are in fall 🍂</p>

      <h2>Heading 2</h2>
      <p>Hello my name is <i>Martin Morissette</i></p>

      <h3>Heading 3</h3>
      <p>Third paragraph with <b>bold1</b> and <b>bold2</b></p>
      HTML
      assert_equal(expected_html.strip, md.to_html)
    end
  end

  def test_markdown_suports_bold
    source = <<~MARKDOWN
    **Bold1** and then **bold2**
    MARKDOWN
    md = ::Markdown.new(source)

    expected_html = <<~HTML
    <p><b>Bold1</b> and then <b>bold2</b></p>
    HTML
    assert_equal(expected_html.strip, md.to_html)
  end

  def test_markdown_suports_italics
    source = <<~MARKDOWN
    *Italic1* and then *italic2*
    MARKDOWN
    md = ::Markdown.new(source)

    expected_html = <<~HTML
    <p><i>Italic1</i> and then <i>italic2</i></p>
    HTML
    assert_equal(expected_html.strip, md.to_html)
  end

  def test_markdown_suports_italics_and_bold_on_the_same_line
    source = <<~MARKDOWN
    *Italic1* and then **bold1** and then *italic2* and then **bold2**
    MARKDOWN
    md = ::Markdown.new(source)

    expected_html = <<~HTML
    <p><i>Italic1</i> and then <b>bold1</b> and then <i>italic2</i> and then <b>bold2</b></p>
    HTML
    assert_equal(expected_html.strip, md.to_html)
  end

  def test_markdown_replaces_usernames_when_enabled
    source = <<~MARKDOWN
    Hello my name is @mmorissette
    MARKDOWN
    md = ::Markdown.new(source, replace_usernames: true)

    expected_html = <<~HTML
    <p>Hello my name is Martin Morissette</p>
    HTML
    assert_equal(expected_html.strip, md.to_html)
  end

  def test_markdown_does_not_replaces_usernames_when_disabled
    source = <<~MARKDOWN
    Hello my name is @mmorissette
    MARKDOWN
    md = ::Markdown.new(source, replace_usernames: false)

    expected_html = <<~HTML
    <p>Hello my name is @mmorissette</p>
    HTML
    assert_equal(expected_html.strip, md.to_html)
  end

  def test_markdown_replaces_template_season
    summer_time = Time.local(2020, 07, 04, 12, 0, 0)
    Timecop.freeze(summer_time) do
      source = <<~MARKDOWN
      We are in {{season}}
      MARKDOWN
      md = ::Markdown.new(source, replace_usernames: true)

      expected_html = <<~HTML
      <p>We are in summer 🌞</p>
      HTML
      assert_equal(expected_html.strip, md.to_html)
    end
  end

  def test_markdown_replaces_template_today
    summer_time = Time.local(2020, 07, 04, 12, 0, 0)
    Timecop.freeze(summer_time) do
      source = <<~MARKDOWN
      Today is {{today}}
      MARKDOWN
      md = ::Markdown.new(source, replace_usernames: true)

      expected_html = <<~HTML
      <p>Today is 2020-07-04</p>
      HTML
      assert_equal(expected_html.strip, md.to_html)
    end
  end

  def test_markdown_replaces_multiple_templates_on_the_same_line
    summer_time = Time.local(2020, 07, 04, 12, 0, 0)
    Timecop.freeze(summer_time) do
      source = <<~MARKDOWN
      Today is {{today}} and we are in {{season}}
      MARKDOWN
      md = ::Markdown.new(source, replace_usernames: true)

      expected_html = <<~HTML
      <p>Today is 2020-07-04 and we are in summer 🌞</p>
      HTML
      assert_equal(expected_html.strip, md.to_html)
    end
  end
end
