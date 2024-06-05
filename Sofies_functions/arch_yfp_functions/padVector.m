% Function to zero-pad vectors to a specified length
function paddedVector = padVector(vector, maxLength)
    paddedVector = zeros(1, maxLength);
    paddedVector(1:length(vector)) = vector;
end