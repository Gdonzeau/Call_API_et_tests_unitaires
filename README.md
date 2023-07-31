# Call_API_et_tests_unitaires

## Présentation
Il s'agit d'u'ne application qui permet d'aller chercher des nouvelles sur un moteur de recherche et d'afficher le résultat sous forme de cellules.

<img src="https://github.com/Gdonzeau/Call_API_et_tests_unitaires/blob/main/CallAPI01.png" width="200" title= "image01" hspace="20"> <img src="https://github.com/Gdonzeau/Call_API_et_tests_unitaires/blob/main/CallAPI02.png" width="200" title= "image01" hspace="20"> <img src="https://github.com/Gdonzeau/Call_API_et_tests_unitaires/blob/main/CallAPI03.png" width="200" title= "image01" hspace="20">

## Contexte
Pour la développer j'ai utilisé async et await, sortis lors de la WWD2021. L'application est développée en SwiftUI en architecture MVVM.

Les tests unitaires couvrent la quasi totalité du ViewModel. La partie non testée est le renvoi d'erreur en cas de caractères inconnus : j'ai essayé plusieurs caractères bizarres mais tous ont été convertis avec succès. Et donc aucune erreur n'a été générée.


