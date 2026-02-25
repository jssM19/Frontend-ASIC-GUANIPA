# Error en la pantalla listado de panciente 

recuerdas que te pedi me agregaras el input de busqueda en el archivo /lib/screen/nominal_register cierto? bueno a hora me aparece este error:

════════ Exception caught by widgets library ═══════════════════════════════════
The following assertion was thrown building Builder:
dependOnInheritedWidgetOfExactType<_ModalScopeStatus>() or dependOnInheritedElement() was called before _ListPatientsState.initState() completed.
When an inherited widget changes, for example if the value of Theme.of() changes, its dependent widgets are rebuilt. If the dependent widget's reference to the inherited widget is in a constructor or an initState() method, then the rebuilt dependent widget will not reflect the changes in the inherited widget.
Typically references to inherited widgets should occur in widget build() methods. Alternatively, initialization based on inherited widgets can be placed in the didChangeDependencies method, which is called after initState and whenever the dependencies change thereafter.

quiero que en el archivo /lib/screen/nominal_register me ayudes a corregir ese error.
