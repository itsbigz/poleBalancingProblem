function force = myFuzzyController_2inputs(angle_theta, angle_velo, fisController)
    force = evalfis([angle_theta angle_velo], fisController);