require "test_helper"

class Refactoring::Ruby::Chap9Test < Minitest::Test
  def test_markdown_to_html
    source = <<~MARKDOWN
    # Heading 1
    First paragraph

    ## Heading 2
    Second paragraph

    ### Heading 3
    Third paragraph
    MARKDOWN
    md = ::Markdown.new(source)

    expected_html = <<~HTML
    <h1>Heading 1</h1>
    <p>First paragraph</p>

    <h2>Heading 2</h2>
    <p>Second paragraph</p>

    <h3>Heading 3</h3>
    <p>Third paragraph</p>
    HTML
    assert_equal(expected_html.strip, md.to_html)
  end
end
