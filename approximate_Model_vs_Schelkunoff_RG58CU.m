clear all; 

mu0 	= 4*pi*10^-7; 					% Vs/Am
eps0	= 8.854*10^-12; 				% As/Vm
c0 		= 299792457; 					% m/s
f 		= logspace(4, 8, 100); 			% Hz
omega 	= 2*pi*f; 						% 1/s


############
% RG 58 C/U, but with dielectric to yield 50 Ohm
############
# Cutoff frequency: 190,85/(sqrt(epsPE)*2*(a+b)) GHz
a		= 0.935/2*10^-3;                % mm
b		= 2.95/2*10^-3;                 % mm
c		= 3.6/2*10^-3;                  % mm
sigma	= 5.85*10^7; 					% 1/Ohm*m
epsRel  = 1.9; 

Lp = mu0/(2*pi)*log(b/a); 				% ln(b/a)
Cp = 2*pi*eps0*epsRel/(log(b/a)); 	    % ln(b/a)

#etac	= sqrt(i*omega*mu0/sigma); 
#gammac	= sqrt(i*omega*mu0*sigma);

# Inner conductor
#ZaHFp	= (1+i)/(2*pi*a)*sqrt(omega*mu0/(2*sigma)); # = 1/(2*pi*a)*sqrt(i*omega*mu0/sigma) 
#yields
RaHFp 	= 1/(2*pi*a)*sqrt(omega*mu0/(2*sigma)); 
LaHFp	= 1/(2*pi*a)*sqrt(mu0./(2*omega*sigma)); 

# Outer conductor
#ZbHFp	= (1+i)/(2*pi*b)*sqrt(omega*mu0/(2*sigma)); # = 1/(2*pi*a)*sqrt(i*omega*mu0/sigma) 
#yields
RbHFp 	= 1/(2*pi*b)*sqrt(omega*mu0/(2*sigma)); 
LbHFp	= 1/(2*pi*b)*sqrt(mu0./(2*omega*sigma)); 

# 	Low Frequencies
RaDCp 	= 1/(pi*a^2*sigma); 
LaIntp 	= mu0/(8*pi); 

RbDCp 		= 1/(2*pi*b*(c-b)*sigma); # should equal 1/(pi*(cx - b)^2), is not. Here, 11 % smaller
RbDCp_bet 	= 1/(pi*(c^2 - b^2)*sigma); 
LbIntp 		= mu0/(2*pi)*(c^4 * log(c/b)/(c^2 - b^2)^2 + (b^2 - 3*c^2)/(4*(c^2 - b^2)));

Zap     = RaDCp + (I*omega*LaIntp.*(RaHFp + I*omega.*LaHFp)) ./ (RaHFp + I*omega.*(LaHFp + LaIntp)); 
Zbp     = RbDCp + (I*omega*LbIntp.*(RbHFp + I*omega.*LbHFp)) ./ (RbHFp + I*omega.*(LbHFp + LbIntp)); 

Ztot    = Zap + Zbp + I*omega*Lp;
Ytot    = I*omega*Cp; 

gammatot	= sqrt(Ztot.*Ytot); 
Zchartot 	= sqrt(Ztot./Ytot); 

##############
# Schelkunoff
##############

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
title('Characteristic Impedance Real Part'); 
loglog(f, real(Zc), 'r-', f, real(Zchartot), 'b-');				% Real part of Characteristic Impedance
legend({'Schelkunoff', 'Tesche'}); 
xlabel('f / Hz'); ylabel('Re{Z_c} / \Omega');
figure
title('Characteristic Impedance Imaginary Part');
loglog(f, imag(Zc), 'r-', f, imag(Zchartot), 'b-');           	% Imaginary part of Characteristic Impedance
legend({'Schelkunoff', 'Tesche'}); 
xlabel('f / Hz'); ylabel('Im{Z_c} / \Omega');
figure
title('Propagation Constant Real Part / \alpha');
loglog(f, real(gammaSchel), 'r-', real(gammatot), 'b-');      	% Attenuation Constant
legend({'Schelkunoff', 'Tesche'}); 
xlabel('f / Hz'); ylabel('Re{\gamma}/ m^{-1}');
figure
title('Propagation Constant Imaginary Part / \beta');
loglog(f, imag(gammaSchel), 'r-', f, imag(gammatot), 'b-');		% Phase constant
legend({'Schelkunoff', 'Tesche'}); 
xlabel('f / Hz'); ylabel('Im{\gamma} / m^{-1}');
