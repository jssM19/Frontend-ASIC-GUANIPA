import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
  final TextEditingController _searchController = TextEditingController();

  List<Paciente> _pacientes = [];
  int _currentPage = 1;
  bool _isLoading = false;
  bool _isLoadingMore = false;
  bool _hasError = false;
  String? _errorMessage;
  bool _hasMoreData = true;

  @override
  void initState() {
    super.initState();
    _loadPacientes();
    _scrollController.addListener(_onScroll);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final searchParam = GoRouterState.of(context).uri.queryParameters['search'];
    if (searchParam != null && _searchController.text.isEmpty) {
      _searchController.text = searchParam;
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
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
        search: _searchController.text.isNotEmpty
            ? _searchController.text
            : null,
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
        search: _searchController.text.isNotEmpty
            ? _searchController.text
            : null,
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

  void _performSearch() {
    final searchText = _searchController.text;
    if (searchText.isNotEmpty) {
      context.go('/list-patients?search=$searchText');
    } else {
      context.go('/list-patients');
    }
    _loadPacientes();
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
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Buscar por nombre, apellido o cédula',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        context.go('/list-patients');
                        _loadPacientes();
                      },
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
            onSubmitted: (_) => _performSearch(),
          ),
        ),
        Expanded(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _hasError
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 64,
                        color: Colors.red,
                      ),
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
                )
              : _pacientes.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.person_off,
                        size: 64,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'No se encontraron pacientes',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
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
}
