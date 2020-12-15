% code ini mensimulasikan 64 x 16 MIMO hybrid beamforming system
% dengan 64-element square array menggunakan 4 RF chain pada sisi
% transmiter
% dan 16-element square array dan 4 RF chain pada sisi receiver 

Nt = 64;
NtRF = 4;

Nr = 16;
NrRF = 4;

% pada simulasi ini, diasumsukan bahwa tiap antena terhubung dengan semua
% RF chain. Maka dari itu, tiap antena terhubung dengan 4 perubah fasa.
% Urutan seperti itu bisa direpresentasikan dengan mempartisi array menjadi
% 4 subarray yang saling terhubung
rng(4096);
c = 3e8;
fc = 28e9;
lambda = c/fc;
txarray = phased.PartitionedArray(...
    'Array',phased.URA([sqrt(Nt) sqrt(Nt)],lambda/2),...
    'SubarraySelection',ones(NtRF,Nt),'SubarraySteering','Custom');
rxarray = phased.PartitionedArray(...
    'Array',phased.URA([sqrt(Nr) sqrt(Nr)],lambda/2),...
    'SubarraySelection',ones(NrRF,Nr),'SubarraySteering','Custom');


Ncl = 6;
Nray = 8;
Nscatter = Nray*Ncl;
angspread = 5;
% compute randomly placed scatterer clusters
txclang = [rand(1,Ncl)*120-60;rand(1,Ncl)*60-30];
rxclang = [rand(1,Ncl)*120-60;rand(1,Ncl)*60-30];
txang = zeros(2,Nscatter);
rxang = zeros(2,Nscatter);
% compute the rays within each cluster
for m = 1:Ncl
    txang(:,(m-1)*Nray+(1:Nray)) = randn(2,Nray)*sqrt(angspread)+txclang(:,m);
    rxang(:,(m-1)*Nray+(1:Nray)) = randn(2,Nray)*sqrt(angspread)+rxclang(:,m);
end

g = (randn(1,Nscatter)+1i*randn(1,Nscatter))/sqrt(Nscatter);

txpos = getElementPosition(txarray)/lambda;
rxpos = getElementPosition(rxarray)/lambda;
H = scatteringchanmtx(txpos,rxpos,txang,rxang,g);

fprintf('Hasil txpos: ');
txpos

fprintf('Hasil rxpos: ');
rxpos

fprintf('Hasil H: ');
H
