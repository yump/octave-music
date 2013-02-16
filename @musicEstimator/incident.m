function [result] = incident (music, theta, phi)
	
	assert (size(theta) == size(phi));

	pvec = zeros( [3,size(theta)] ); %oppan vector style
	[pvec(1,:,:), pvec(2,:,:), pvec(3,:,:)] = sph2cart(theta,phi,-1(ones(size(phi))));
%	pvec(1,:,:) = -cos(azi).*cos(elev);
%	pvec(2,:,:) = -sin(azi).*cos(elev);
%	pvec(3,:,:) = -sin(elev);
	
	result = pmu(music, pvec);

endfunction
