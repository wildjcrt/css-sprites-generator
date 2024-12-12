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
      "#{images_root_path}/goals.png",
      "#{images_root_path}/rest.png",
      "#{images_root_path}/warehouse.png",
    ]
    sprited_others_path = "#{images_root_path}/others.png"
    system("convert #{others.join(' ')} +append #{sprited_others_path}")

    scores_path = "#{images_root_path}/scores.png"
    system("convert #{sprited_streets_path} #{sprited_events_path} #{sprited_others_path} #{scores_path} -append #{images_root_path}/eirakuchotori-resources.png")
    system("rm #{sprited_streets_path}")
    system("rm #{sprited_events_path}")
    system("rm #{sprited_others_path}")
  end
end
