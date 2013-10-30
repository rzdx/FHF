parfor i = 1:n
   if testLevel(k)
      A = A + i;
   else
      A = [A, 4+i];
   end
   % loop body continued
end
