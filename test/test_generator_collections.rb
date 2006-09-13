##############################################################
# Copyright 2006, Ben Bleything <ben@bleything.net> and      #
#                 Patrick May <patrick@hexane.org>           #
#                                                            #
# Distributed under the MIT license.                         #
##############################################################

require 'test/unit'
require 'plist'

class TestGeneratorCollections < Test::Unit::TestCase
  def test_array
    expected = <<END
<array>
	<integer>1</integer>
	<integer>2</integer>
	<integer>3</integer>
</array>
END

    assert_equal expected, [1,2,3].to_plist(false)
  end

  def test_hash
    expected = <<END
<dict>
	<key>foo</key>
	<string>bar</string>
</dict>
END
    # only one element because we can't predict what order the keys will come out in.  Sigh.
    assert_equal expected, {:foo => :bar}.to_plist(false)
  end

  def test_hash_with_array_element
    expected = <<END
<dict>
	<key>ary</key>
	<array>
		<integer>1</integer>
		<string>b</string>
		<string>3</string>
	</array>
</dict>
END
    assert_equal expected, {:ary => [1,:b,'3']}.to_plist(false)
  end

  def test_array_with_hash_element
    expected = <<END
<array>
	<dict>
		<key>foo</key>
		<string>bar</string>
	</dict>
	<string>b</string>
	<integer>3</integer>
</array>
END

    assert_equal expected, [{:foo => 'bar'}, :b, 3].to_plist(false)
  end
end
