require 'irb/completion'
require "irb/ext/save-history"
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "/config/.ruby-history"
IRB.conf[:USE_MULTILINE] = true
