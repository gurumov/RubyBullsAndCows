require './config/boot'

#===============================================================================
# Map Top Level Controllers
#===============================================================================

controllers = [
   BullsAndCows::AuthController,
   BullsAndCows::MainController,
   BullsAndCows::GameController,
   BullsAndCows::AboutController,
   BullsAndCows::RankingsController
]

controllers.each do |controller|
  map (controller::NAMESPACE) { run controller }
end
