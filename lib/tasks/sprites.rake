namespace :sprites do
  desc "Create sprites image"
  task images: :environment do
    images_root_path = "#{Rails.root}/app/assets/images"
    streets = [
      "#{images_root_path}/street-01.png",
      "#{images_root_path}/street-02.png",
      "#{images_root_path}/street-03.png",
      "#{images_root_path}/street-04.png",
      "#{images_root_path}/street-05.png",
      "#{images_root_path}/street-06.png",
      "#{images_root_path}/street-07.png",
      "#{images_root_path}/street-08.png",
      "#{images_root_path}/street-09.png",
      "#{images_root_path}/street-10.png",
      "#{images_root_path}/street-11.png",
      "#{images_root_path}/street-12.png",
      "#{images_root_path}/street-13.png",
      "#{images_root_path}/street-14.png",
    ]
    sprited_streets_path = "#{images_root_path}/streets.png"
    system("convert #{streets.join(' ')} +append #{sprited_streets_path}")

    events = [
      "#{images_root_path}/event-1908.png",
      "#{images_root_path}/event-1920.png",
      "#{images_root_path}/event-1923.png",
      "#{images_root_path}/event-1931.png",
      "#{images_root_path}/event-1945.png",
      "#{images_root_path}/event-1947.png",
    ]
    sprited_events_path = "#{images_root_path}/events.png"
    system("convert #{events.join(' ')} +append #{sprited_events_path}")

    others = [
      "#{images_root_path}/scores-goals-rest.png",
      "#{images_root_path}/warehouse.png",
    ]
    sprited_others_path = "#{images_root_path}/others.png"
    system("convert #{others.join(' ')} +append #{sprited_others_path}")

    system("convert #{sprited_streets_path} #{sprited_events_path} #{sprited_others_path} -append #{images_root_path}/eirakuchotori-resources.png")
    system("rm #{sprited_streets_path}")
    system("rm #{sprited_events_path}")
    system("rm #{sprited_others_path}")

    system("convert #{images_root_path}/Cube_top.png #{images_root_path}/30_30_colored_dice.png -append #{images_root_path}/cubes-and-dice.png")
  end

  desc "Create css file"
  task css: :environment do
    css_path = "#{Rails.root}/app/assets/stylesheets/sprites.css"
    bg_width = 9940

    File.open(css_path, "w") do |file|
      file.puts <<~CSS
        .cube {
          background: no-repeat url('/cubes-and-dice.png');
          width: 30px;
          height: 32px;
        }

        .yellow {
          background-size: 320px;
          background-position: -192px 0px;
        }

        .blue {
          background-size: 320px;
          background-position: -32px 0px;
        }

        .dice {
          width: 30px;
          height: 30px;
          position: absolute;
        }

        #dice1 {
          background: no-repeat url('/cubes-and-dice.png');
          background-position: 0px -124px;
        }

        #dice2 {
          background: no-repeat url('/cubes-and-dice.png');
          background-position: -30px -124px;
        }

        #dice3 {
          background: no-repeat url('/cubes-and-dice.png');
          background-position: -60px -124px;
        }

        #dice4 {
          background: no-repeat url('/cubes-and-dice.png');
          background-position: -90px -124px;
        }

        #dice5 {
          background: no-repeat url('/cubes-and-dice.png');
          background-position: -120px -124px;
        }

        #dice6 {
          background: no-repeat url('/cubes-and-dice.png');
          background-position: -150px -124px;
        }

        .resource {
          background: no-repeat center url('/eirakuchotori-resources.png');
          background-size: 0px;
        }

      CSS

      # for portrait card: streets and events
      image_width = 710
      card_width = 120
      background_size = (card_width * bg_width.to_f / image_width).round

      position_width = ((background_size / bg_width.to_f) * image_width).round
      (1..14).each do |i|
        file.puts <<~CSS
          #street-#{i} {
            background-size: #{background_size}px;
            background-position: -#{position_width*(i-1)}px 0px;
          }
          #{}
        CSS
      end

      position_height = ((background_size / bg_width.to_f) * 1076).round
      %w[1908 1920 1923 1931 1945 1947].each_with_index do |year, i|
        file.puts <<~CSS
          #event-#{year} {
            background: no-repeat url('/eirakuchotori-resources.png');
            background-size: #{background_size}px;
            background-position: -#{position_width*i}px -#{position_height}px;
            height: 182px;
          }
          #{}
        CSS
      end

      # for tapped card: warehouse
      image_width = 1076
      tapeed_card_width = 248
      background_size = (tapeed_card_width * bg_width.to_f / image_width).round

      # street 和 event 高度都是 1076，所以橫卡起始高度為 1076+1076
      # scores-goals-rest.png 寬度 900
      start_height = 1076+1076
      position_height = ((background_size / bg_width.to_f) * start_height).round
      position_width = ((background_size / bg_width.to_f) * 900).round
      file.puts <<~CSS
        #warehouse-1, #warehouse-2 {
          background-size: #{background_size}px;
          background-position: -#{position_width}px -#{position_height}px;
        }
        #{}
      CSS

      image_width = 900
      board_width = 468
      background_size = (board_width * bg_width.to_f / image_width).round
      position_height = ((background_size / bg_width.to_f) * start_height).round
      file.puts <<~CSS
        #scores-goals-rest {
          background-size: #{background_size}px;
          background-position: 0px -#{position_height}px;
        }
        #{}
      CSS
    end
  end
end
