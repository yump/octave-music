#!/usr/bin/octave

% Test the iterative DOA finding function

shared %shared test components

disp('Attempting to find DOA');
t = cputime;
doa = doasearch(estimator,[-pi/2 pi/2 -pi/2 pi/2]);
t = cputime - t;
printf('Took %f seconds of CPU time\n',t);
realdoa = (cart2sph(-s2')(1:2))';
err = doa - realdoa;
lsqerr = log10(sqrt(sum(err.^2)));
printf('Approximte distance error is 10^%f\n',lsqerr);
printf('Absolute error is\n');
err

