%% Menghitung probabilitas paket berhasil dikirim 
%  ada 3 input, yaitu jumlah device (M), jumlah channel(R), dan jumlah time
%  slot(T)
%  Output berupa banyak paket yang sukses dikirim (S) dan probabilitas paket 
%  sukses dikirim (prob)

%% Input dan array preparation
message1 = 'Jumlah Device : ';
message2 = 'Jumlah Channel : ';
message3 = 'Jumlah Time Slot : ';
message4 = 'Success in Channel: ';
message5 = 'Collision in Channel: ';
message6 = 'Jumlah Paket yang sukses dikirim: ';
message7 = 'Probabilitas paket terkirim: ';

M = input(message1);                        %input jumlah device
R = input(message2);                        %input jumlah channel/frekuensi
T = input(message3);                        %input jumlah time slot
display(['===========================']);
S = 0;                                      %value paket yang sukses dikirim
arr_pre = [];                               %array yang digunakan untuk menyimpan list channel random
arr_dev = [];                               %array yang digunakan untuk menyimpan list device
arr_dup = [];

%% Menghitung banyak paket dan probabilitas paket dikirim
for t = 1:T                                 %loop per time slot
    fprintf(['Timeslot: ' num2str(t) '\n']);
    for m = 1:M                             %loop per device
        arr_dev = [arr_dev; m];             %memasukkan device kedalam list
        arr_pre = [arr_pre; randi([1 R])];  %membuat list random channel dengan range 1-R
    end
    
    fprintf(['List Device: [' num2str(arr_dev(:).') ']\n' ]);
    fprintf(['Choosen Channel: [' num2str(arr_pre(:).') ']\n' ]);
    
    for c = 1:length(arr_pre)               %loop per channel didalam array
        F = table(arr_dev, arr_pre);        %membuat table relasi device-channel
        F = groupcounts(F, 'arr_pre');      %menghitung berapa device yang ada pada suatu channel, group by channel
        C = F.GroupCount == 1;
        E = F.GroupCount > 1;
        D = F.arr_pre(C);                   %mengambil value dari jumlah device per channel, bentuk berupa array
        G = F.arr_pre(E);
    end
    
    fprintf([message4, '[' num2str(D(:).') ']\n']);                        %mengambil channel yang hanya memiliki tepat satu buah device
    fprintf([message5, '[' num2str(G(:).') ']\n']);
    S = sum(C) + S;                         %menghitung jumlah channel berdasarkan ketentuan D ditambah jumlah paket yang sukses
                                            %pada time slot sebelumnya
    arr_dev = [];                           %mengosongkan array device untuk time slot selanjutnya
    arr_pre = [];                           %mengosongkan array channel untuk time slot selanjutnya
end

prob = S/(M*T);                             %menghitung probabilitas paket berhasil dikirim

%% Menampilkan hasil
S = [message6, num2str(S) '\n'];             
P = [message7, num2str(prob) '\n'];
fprintf(S);                                 %menampilkan banyak paket yang sukses dikirim
fprintf(P);                                 %menampilkan probabilitas paket berhasil dikirim
           
