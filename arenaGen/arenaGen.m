recallArena = 0;
arenaName = 'S2_3d';
if recallArena == 0
    nObst      = 1;               % Number of Obstacles
    nTarg      = 1;                % Number of targets
    arenaSelection = 'SpW_UD'; % e.g 'EW', 'HW', 'SW', 'UW', 'WW', 'XW', 'CAW', 'MW', 'SpW', 'SpW_UD'
    arenaSize = [0,0,840,600];
    [arena, obstacles, targets] = createArena(arenaSize, nObst, nTarg, arenaName, arenaSelection);
end