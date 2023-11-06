# SuceavaPass

## Descriere
Acest proiect este o aplicație iOS care permite utilizatorilor să folosească gratuit transportul public din Suceava.

## Caracteristici
- Generarea de coduri QR
- Generarea de coduri QR care sunt valabile pentru o anumită perioadă de timp folosind un cronometru
- Informarea utilizatorilor folosind un cronometru care rulează în fundal
- Crearea și plasarea de spații între vizualizări

## Utilizare
Sunt necesare cunoștințe de Xcode și Swift/Obj-C pentru ca proiectul să funcționeze. Puteți urma pașii de mai jos pentru a obține informații detaliate despre utilizarea aplicației sau a modulului:

1. **Download or Clone the Project** (Descărcați sau clonați proiectul)
git clone [https://github.com/ioanaydgn/Suceava.git]

2. **Deschideți cu Xcode**
- 3. Porniți Xcode.
- Faceți clic pe "Open" (Deschidere) din meniul File (Fișier).
- Selectați directorul proiectului descărcat.

3. **Editarea și testarea codului**
- Puteți să editați proiectul, să faceți modificări și să îl rulați în Xcode.
- Puteți găsi note specifice privind utilizarea și detalii ale aplicației în fișiere precum `generatorQRViewController.m` sau `generatorQRViewController.swift`.

## Exemple de fragmente de cod

### Adăugați spațiu între vizualizări
```obiectiv-c
NSLayoutConstraint *leadingConstraint = [NSLayoutConstraint constraintWithItem:self.viewQR
                                                          attribute:NSLayoutAttributeLeading
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.viewAtention
                                                          atribut:NSLayoutAttributeLeading
                                                         multiplicator:1.0
                                                           constant:50.0]; // spațiu de 50px

NSLayoutConstraint *trailingConstraint = [NSLayoutConstraint constraintWithItem:self.viewQR
                                                           attribute:NSLayoutAttributeTrailing
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self.viewAtention
                                                           atribut:NSLayoutAttributeTrailing
                                                          multiplicator:1.0
                                                            constant:-50.0]; // spațiu de 50px

[self.view addConstraint:leadingConstraint];
[self.view addConstraint:trailingConstraint];
```

## Generarea și afișarea codurilor QR
```obiectiv-c
// Generarea codurilor QR
CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
[filter setDefaults];
NSString *randomNumber = [self generateRandomNumber];
NSData *data = [randomNumber dataUsingEncoding:NSUTF8StringEncoding];
[filter setValue:data forKey:@"inputMessage"];
CIImage *outputImage = [filter outputImage];
CIContext *context = [CIContext contextWithOptions:nil];
CGImageRef cgImage = [context createCGImage:outputImage fromRect:outputImage.extent];
UIImage *qrCode = [UIImage imageWithCGImage:cgImage];
CGImageRelease(cgImage);

// Afișarea codului QR generat
self.imageView.image = qrCode;
```

## Crearea unui cod QR pentru o anumită perioadă folosind un cronometru
```obiectiv-c
// Se ia ora curentă și se adaugă 100 de minute
NSString *currentDateString = self.text1.text;
NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
[dateFormatter setDateFormat:@"dd-MM-yyyy HH:mm"]];
NSDate *startDate = [dateFormatter dateFromString:currentDateString];

NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
[dateComponents setMinute:100];
NSCalendar *calendar = [NSCalendar currentCalendar];
NSDate *futureDate = [calendar dateByAddingComponents:dateComponents toDate:startDate options:0];

NSString *futureDateString = [dateFormatter stringFromDate:futureDate];
self.text2.text = futureDateString;

NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
[[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
```
