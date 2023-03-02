# Rosu Mihai Cosmin 323CA

rotp.asm:
-In rezolvarea task-ului 1 am folosit instructiunea de loop care foloseste
registrul ecx pe post de contor i mergand de la len la 0.
-Mai intai retin in eax valoarea len - i - 1, apoi mut in registrul bl
caracterul curent (de pe pozitia i) din plaintext si aplic operatia de xor
intre el si caracterul de pe pozitia len - i - 1 din key.
-La sfarsit mut rezultatul din bl in ciphertext la pozitia i.
-Inainte sa se termine programul mai intru o data in while deoarece folosind
instructiunea loop nu acopar cazul cand ecx este 0. Din acest motiv este
necesar si if-ul (je-ul) de la sfarsitul while-ului.

ages.asm:
-Incep programul prin interschimbarea registrilor ecx si edx pentru a folosi
instructiunea loop (unde ecx este contor de la len la 0). De asemenea,
decrementez valoarea din ecx, intrucat vectorul cu dati are indici de la 0 la
len - 1.
-In while incep prin a prelua valoarea anului din data de pe pozitia i si a o
compara cu valoarea anului din data prezenta.
-In cazul in care anul prezent este mai mic decat cel din data de pe pozitia i
inseamna ca persoana nascuta in anul precizat are 0 ani.
-Altfel trec la compararea lunilor, dar nu inainte sa calculez varsta maxima pe
care o poate avea persoana (daca si-a serbat ziua si in anul prezent).
-In cazul lunilor se pot obtine trei cazuri. Daca luna prezenta este mai mica
decat cea din data de nastere a persoanei inseamna ca aceasta nu si-a serbat
inca ziua deci varsta ei este cea calculata - 1. Daca cele doua luni sunt egale
trebuie comparate zilele, iar daca luna prezenta este mai mare inseamna ca
persoana si-a serbat ziua anul acesta deci are varsta maxima calculata.
-In cazul zilelor avem doua cazuri. Daca ziua prezenta este mai mica inseamna
ca persoana are varsta calculata - 1, altfel are varsta calculata.
-La sfarsitul programului trebuie sa mai intru o data in while pentru cazul
cand ecx este 0, si sa adaug la sfarsitul while-ului je-ul pentru iesire.
-Inainte de terminarea programului interschimb din nou registrii ecx si edx
pentru a transmite rezultatele corect.

columnar.asm:
-In rezolvarea task-ului 3 nu am mai folosit instructiunea loop si am simulat
un while folosind un jump cu conditie si unul fara. De asemenea, contorul este
o variabila declarata in .data.
-Incep rezolvarea cu un while care parcurge vectorul de chei si preiau coloana
pe care trebuie sa parcurg matricea.
-Apoi parcurg ciphertext-ul, si respectiv matricea din len_cheie in len_cheie
pentru a adauga caracterele de pe coloana matricei in ciphertext.
-Pentru a verifica daca am iesit din matrice, consider ca matricea este un
vector si calculez pozitia din acest vector. Acest vector are lungimea textului
initial (plaintext), deci daca pozitia curenta este mai mare sau egala cu
len_haystack (lungimea plaintext-ului) atunci inseamna ca trebuie sa ies din
while.

cache.asm:
-In rezolvarea task-ului 4 am folosit push-uri pentru a-mi elibera temporar
registrii, iar cand nu mai sunt necesari le reatribui valoarea de pe stiva. De
asemenea, am folosit doua variabile declarate in .data.
-Incep rezolvarea prin calcularea tag-ului adresei primite. Apoi parcurg
vectorul de tag-uri.
-Daca gasesc un tag egal cu cel al adresei curente inseamna ca pot da load din
cache. Prin urmare, mut intr-un registru adresa liniei din cache de pe pozitia
pe care am gasit tag-ul in lista tag-urilor. Apoi preiau valoarea de la aceasta
adresa plus offset-ul obtinut din ultimii trei biti din adresa primita si o pun
in adresa din eax.
-Daca nu gasesc tag-ul in lista, inseamna ca trebuie sa populez linia din cache
si sa adaug tag-ul in lista de tag-uri.
-Incep prin adaugarea tag-ului pe pozitia edi (to_replace) primita ca
parametru. Apoi preiau adresa liniei cu indicele to_replace din cache si o
populez cu elemente de la adresele care incep cu tag-ul adresei curente (care
se termina in 000). Pe orice linie din cache sunt 8 elemente deci adresa
ultimului se termina in 111.
-Dupa popularea cache-ului pot da load elementului de pe linie care se afla pe
pozitia data de offset, pe care il mut in adresa din eax.
