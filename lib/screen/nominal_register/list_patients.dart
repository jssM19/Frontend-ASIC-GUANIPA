import 'package:flutter/material.dart';
import 'package:asis_guanipa_frontend/models/paciente.dart';
import 'package:asis_guanipa_frontend/services/api_service.dart';
import 'package:asis_guanipa_frontend/components/card_paciente.dart';

class ListPatients extends StatefulWidget {
  const ListPatients({super.key});

  @override
  State<ListPatients> createState() => _ListPatientsState();
}

class _ListPatientsState extends State<ListPatients> {
  final ApiService _apiService = ApiService();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _cedulaController = TextEditingController();

  List<Paciente> _pacientes = [];
  int _currentPage = 1;
  bool _isLoading = false;
  bool _isLoadingMore = false;
  bool _hasError = false;
  String? _errorMessage;
  String? _selectedFecha;
  bool _hasMoreData = true;

  @override
  void initState() {
    super.initState();
    _loadPacientes();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _cedulaController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isLoadingMore || !_hasMoreData) return;
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _loadMorePacientes();
    }
  }

  Future<void> _loadPacientes({bool reset = true}) async {
    if (reset) {
      setState(() {
        _currentPage = 1;
        _pacientes = [];
        _isLoading = true;
        _hasError = false;
        _errorMessage = null;
        _hasMoreData = true;
      });
    }

    try {
      final response = await _apiService.getPacientes(
        page: _currentPage,
        cedula: _cedulaController.text.isNotEmpty
            ? _cedulaController.text
            : null,
        fecha: _selectedFecha,
      );

      if (mounted) {
        setState(() {
          if (response.success && response.data.isNotEmpty) {
            _pacientes = response.data;
            _hasMoreData = response.data.length >= 20;
          } else if (response.success && response.data.isEmpty) {
            _hasMoreData = false;
          } else {
            _hasError = true;
            _errorMessage = 'Error al cargar pacientes';
          }
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _hasError = true;
          _errorMessage = 'Error de conexión';
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _loadMorePacientes() async {
    if (_isLoadingMore) return;

    setState(() {
      _isLoadingMore = true;
    });

    try {
      final nextPage = _currentPage + 1;
      final response = await _apiService.getPacientes(
        page: nextPage,
        cedula: _cedulaController.text.isNotEmpty
            ? _cedulaController.text
            : null,
        fecha: _selectedFecha,
      );

      if (mounted) {
        setState(() {
          if (response.success && response.data.isNotEmpty) {
            _pacientes.addAll(response.data);
            _currentPage = nextPage;
            _hasMoreData = response.data.length >= 20;
          } else {
            _hasMoreData = false;
          }
          _isLoadingMore = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoadingMore = false;
        });
      }
    }
  }

  void _showFilterDialog() {
    final TextEditingController cedulaFilterController = TextEditingController(
      text: _cedulaController.text,
    );
    String? selectedFecha = _selectedFecha;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Filtros de Búsqueda'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: cedulaFilterController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Cédula',
                        hintText: 'Ingrese la cédula',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.badge),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            selectedFecha != null
                                ? 'Fecha: ${_formatDate(selectedFecha!)}'
                                : 'Sin fecha seleccionada',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () async {
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime.now(),
                            );
                            if (picked != null) {
                              setDialogState(() {
                                selectedFecha =
                                    '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
                              });
                            }
                          },
                          icon: const Icon(Icons.calendar_today),
                          label: const Text('Seleccionar'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    setDialogState(() {
                      cedulaFilterController.clear();
                      selectedFecha = null;
                    });
                  },
                  child: const Text('Limpiar'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _cedulaController.text = cedulaFilterController.text;
                    setState(() {
                      _selectedFecha = selectedFecha;
                    });
                    _loadPacientes();
                    Navigator.pop(context);
                  },
                  child: const Text('Buscar'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  String _formatDate(String date) {
    if (date.isEmpty) return '';
    try {
      final dateTime = DateTime.parse(date);
      return '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year}';
    } catch (e) {
      return date;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Pacientes'),
        backgroundColor: Colors.blue,
        actions: [
          if (_currentPage > 1)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    'Página $_currentPage',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: _showFilterDialog,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.search, color: Colors.white),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_hasError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              _errorMessage ?? 'Error desconocido',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadPacientes,
              child: const Text('Reintentar'),
            ),
          ],
        ),
      );
    }

    if (_pacientes.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.person_off, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            const Text(
              'No se encontraron pacientes',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _showFilterDialog,
              child: const Text('Aplicar filtros'),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        if (_cedulaController.text.isNotEmpty || _selectedFecha != null)
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.blue[50],
            child: Row(
              children: [
                const Icon(Icons.filter_alt, size: 18, color: Colors.blue),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _buildFilterText(),
                    style: const TextStyle(color: Colors.blue),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    _cedulaController.clear();
                    setState(() {
                      _selectedFecha = null;
                    });
                    _loadPacientes();
                  },
                  child: const Text('Limpiar'),
                ),
              ],
            ),
          ),
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            itemCount: _pacientes.length + (_isLoadingMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == _pacientes.length) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return CardPaciente(paciente: _pacientes[index]);
            },
          ),
        ),
      ],
    );
  }

  String _buildFilterText() {
    final filters = <String>[];
    if (_cedulaController.text.isNotEmpty) {
      filters.add('Cédula: ${_cedulaController.text}');
    }
    if (_selectedFecha != null) {
      filters.add('Fecha: ${_formatDate(_selectedFecha!)}');
    }
    return filters.join(' | ');
  }
}
