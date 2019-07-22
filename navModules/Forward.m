function dvI = Forward(velo)
dvI = [1 0 0; 0 1 0; 0 0 1]*[1/2 1/2 0; 0 0 1; 1/(2) -1/(2) 0]*[velo(1); velo(2); velo(3)];
end