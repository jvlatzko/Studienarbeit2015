% EXAMPLE - INSERT $PATH TO S-PARAMETERS HERE
S11_l   = load('$PATH');  
S21_l   = load('$PATH'); 
S12_l   = load('$PATH');
S22_l   = load('$PATH');
S11c    = S11_l(:,2) + I*S11_l(:,3);  
S21c    = S21_l(:,2) + I*S21_l(:,3); 
S12c    = S12_l(:,2) + I*S12_l(:,3);  
S22c    = S22_l(:,2) + I*S22_l(:,3); 
Z01c    = S11_l(:,4) + I*S11_l(:,5); 
Z02c    = S22_l(:,4) + I*S22_l(:,5); 
F_l     = S11_l(:,1);  
% EXAMPLE - SET LENGTH HERE
linelength = 300*10^-3; 
englp   = (2*S21c)./ (1 - S11c.^2 + S21c.^2 ...
+ sqrt((1+S11c.^2-S21c.^2).^2 - 4*S11c.^2));  
Zcp     = Z01c .* sqrt( ((1 + S11c).^2 - S21c.^2) ...
./ ((1 - S11c).^2 - S21c.^2) );  
glp     = - log (englp);  
gammap  = glp./linelength; 

%Tesche:  RG58C/U
mu0     = 4*pi*10^-7; eps0 = 8.854*10^-12; c0 = 299792457;  
omega   = 2*pi*F_l*10^6; 
a = 0.935/2*10^-3; b = 2.95/2*10^-3; c = 3.6/2*10^-3;  
sigma   = 5.8*10^7; epsRel = 1.9;  
Lp      = mu0/(2*pi)*log(b/a); 
Cp      = 2*pi*eps0*epsRel/(log(b/a));  

% Inner conductor
RaHFp   = 1/(2*pi*a)*sqrt(omega*mu0/(2*sigma));  
LaHFp   = 1/(2*pi*a)*sqrt(mu0./(2*omega*sigma));  
RbHFp   = 1/(2*pi*b)*sqrt(omega*mu0/(2*sigma));  
LbHFp   = 1/(2*pi*b)*sqrt(mu0./(2*omega*sigma));  
RaDCp   = 1/(pi*a^2*sigma);  
LaIntp  = mu0/(8*pi);  

% Outer conductor
RbDCp  = 1/(pi*(c^2 - b^2)*sigma);  
LbIntp = mu0/(2*pi)*(c^4 * log(c/b)/(c^2 - b^2)^2 + (b^2 - 3*c^2)/(4*(c^2 - b^2))); 
Zap    = RaDCp + (i*omega*LaIntp.*(RaHFp + i*omega.*LaHFp)) ./ (RaHFp + i*omega.*(LaHFp + LaIntp));  
Zbp    = RbDCp + (i*omega*LbIntp.*(RbHFp + i*omega.*LbHFp)) ./ (RbHFp + i*omega.*(LbHFp + LbIntp));  
ZTtot  = Zap + Zbp + i*omega*Lp; 
YTtot  = i*omega*Cp;  
gTtot  = sqrt(Ztot.*Ytot);  
ZcTtot = sqrt(Ztot./Ytot); 

% Prepare writeout
dZcCST    = [F_l real(Zcp) imag(Zcp)];  
dZcTesche = [F_l real(ZcTtot) imag(ZcTtot)];  
dGCST     = [F_l real(gammap) imag(gammap)];  
dGTesche  = [F_l real(gammatot) imag(gTtot)];  
% Calculate deviations
devAlpha  = abs((real(gammap)-real(gTtot)))./abs(real(gTtot)); 
devBeta   = abs((imag(gammap)-imag(gTtot)))./abs(imag(gTtot)); 
dGDev     = [F_l  devAlpha devBeta];  
dboO      = [F_l omega./imag(gammap) omega./imag(gammatot) c0*ones(size(F_l))]; 

csvwrite("Zc_CST.csv", dZcCST);  
csvwrite("Zc_Tesche.csv", dZcTesche);  
csvwrite("Gamma_CST.csv", dGCST);  
csvwrite("Gamma_Tesche.csv", dGTesche);  
csvwrite("Gamma_Deviation.csv", dGdev);  
csvwrite("Beta_over_Omega.csv", dboO);