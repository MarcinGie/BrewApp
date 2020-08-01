BrewApp README:

IMPORTANT: In order to preserve disc space, archived project doesn't contain required pods. Project requires *pod install* to compile:

	- If user doesn't have *cocoapods* installed, a suitable instructions can be found under https://guides.cocoapods.org/using/getting-started.html.
	- If user has *cocoapods* installed, it is required to open Terminal, go to project's directory and run *pod install* command before attempting to run the project.

Project consists of:

    - List view that after successful fetch shall contain beer objects with image, name and ABV.
    - Detail view that contains info about a selected Beer with name, image, abv, hops, malts, methods.

Business logic of:

    - decoding *punkapi* response in Store
    - presentation logic in ViewModel
    - error handling in Store

is covered by unit tests of BrewAppTests scheme.

Sincerely,
Marcin
