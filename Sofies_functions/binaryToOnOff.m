% Define the binary_to_OnOff function
function [onset, offset] = binaryToOnOff(binaryVector)
    diffVec = diff([0, binaryVector, 0]);
    onset = find(diffVec == 1);
    offset = find(diffVec == -1) - 1;
end