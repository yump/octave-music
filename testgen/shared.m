#!/usr/bin/octave

load circtennas.dat
antennas = antennas * 2; %radius 2


s1 = [-1 0 0]';                        %straight on
s3 = -sph2cart([pi/4*(rand - 0.5), pi/4*(rand -0.5), 1])';
s2 = -sph2cart([pi/4*(rand - 0.5), pi/4*(rand -0.5), 1])';
s4 = -sph2cart([pi/4*(rand - 0.5), pi/4*(rand -0.5), 1])';

%rotating signal
th = pi/8;
rot = [cos(th) -sin(th) 0; sin(th) cos(th) 0; 0 0 1];
if ( ! exist('s5') )
	s5 = s1;
	disp('Created s5');
end
s5 = rot*s5;
%cart2sph(s5')

numsamples = 32;
snr=20;
sample1 = testgen(antennas, s1, numsamples, snr);
sample2 = testgen(antennas, s2, numsamples, snr);
sample3 = testgen(antennas, s3, numsamples, snr);
sample4 = testgen(antennas, s4, numsamples, snr);
sample5 = testgen(antennas, s5, numsamples, snr);
sample = sample2 + sample1;

estimator = musicEstimator(antennas, sample, 2);

