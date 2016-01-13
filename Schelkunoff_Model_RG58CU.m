clear all; 

mu0 	= 4*pi*10^-7; 					% Vs/Am
eps0	= 8.854*10^-12; 				% As/Vm
c0 		= 299792457; 					% m/s


############
# RG 58 C/U
############

a		= 0.935/2*10^-3;                % mm
b		= 2.95/2*10^-3;                 % mm
c		= 3.6/2*10^-3;                  % mm
sigma	= 5.8*10^7; 					% 1/Ohm*m
epsPE	= 1.9; 

Lp = mu0/(2*pi)*log(b/a); 			    % ln(ra/ri)
Cp = 2*pi*eps0*epsPE/(log(b/a)); 	    % ln(ra/ri)

f   = logspace(3, 8, 100); 
omega = 2*pi*f; 


etac	= sqrt(I*omega*mu0/sigma); 
gammac	= sqrt(I*omega*mu0*sigma);


Zap	= etac/(2*pi*a).*(besseli(0, gammac*a) ./ besseli(1, gammac*a)); 
Zbp	= etac/(2*pi*b).*(besseli(0, gammac*b) .* besselk(1, gammac*c) .+ besselk(0, gammac*b) .* besseli(1, gammac*c)) ...
./ ( besseli(1, gammac*c) .* besselk(1, gammac*b) - besseli(1, gammac*b) .* besselk(1, gammac*c)); 


ZpSchel	= I*omega*Lp + Zap + Zbp; 
YpSchel	= I*omega*Cp; 

Zc = sqrt(ZpSchel./YpSchel); 
gammaSchel = sqrt(ZpSchel .* YpSchel); 

###########
# Plotting
###########

figure
loglog(f, real(Zc))				% Real part of Characteristic Impedance
xlabel('f / Hz'); ylabel('Re{Z_c} / \Omega');
figure
loglog(f, imag(Zc));           	% Imaginary part of Characteristic Impedance
xlabel('f / Hz'); ylabel('Im{Z_c} / \Omega');
figure
loglog(f, real(gammaSchel))      % Attenuation Constant
xlabel('f / Hz'); ylabel('Re{\gamma}/ m^{-1}');
figure
loglog(f, imag(gammaSchel))		% Phase constant
xlabel('f / Hz'); ylabel('Im{\gamma} / m^{-1}');