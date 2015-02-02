module.exports =

  class AutoEncodingForRubyEditor
    encodingText: '#encoding: utf-8'
    text: '#encoding: utf-8\n'

    isRubyFile: (filePath)->
      pattern = ///    # begin of regex
                  \.   #
                  e?rb   # ruby or erb extensions
                  $    # end of line
                ///i   # ignore case

      filePath.match pattern
