import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_homework_app/src/model/asignatura_model.dart';
import 'package:my_homework_app/src/model/tarea_model.dart';

class FirestoreService {
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _usersCollection = FirebaseFirestore.instance.collection('users');
  

  Future<void> agregarUsuario(String userId) async {
    _usersCollection.doc(userId); 
  }

  Future<void> agregarTarea(String userId, Tarea tarea) async {
    
    final tareasCollection = _usersCollection.doc(userId);
    final tareas = tareasCollection.collection('tareas');
    await tareas.add({
      'id': tarea.id,
      'titulo': tarea.titulo,
      'descripcion': tarea.descripcion,
      'fechaLimite': tarea.fechaLimite.toIso8601String(),
      'fechaInicio': tarea.fechaInicio?.toIso8601String(),
      'asignatura': tarea.asignatura.toMap(),
      'completada': tarea.completada ? 1 : 0, // Convertir bool a int
    });
  }

  Future<void> agregarAsignatura(String userId, Asignatura asignatura) async {
    
    final asignaturasCollection = _usersCollection.doc(userId);
    final asignaturas = asignaturasCollection.collection('asignaturas');
    await asignaturas.add({
      'nombre': asignatura.nombre,
      'color': asignatura.color.toString(), // Guardar el color como un entero
    });
  }

  Future<List<Tarea>> obtenerTareas(String userId) async {
    
    final userDocument = _usersCollection.doc(userId);
    final tareasDocument = userDocument.collection('tareas');
    final tareasSnapshot = await tareasDocument.get();

    List<Tarea> tareas = [];
    tareas = tareasSnapshot.docs.map((doc) {
          final tareaData = doc.data();
          return Tarea.fromMap({...tareaData
, 'id': doc.id, 
'asignatura': Asignatura.fromMap(tareaData['asignatura'])
          });
        }).toList();

    return tareas;
  }

  Future<List<Asignatura>> obtenerAsignaturas(String userId) async {
    
    final userDocument = _usersCollection.doc(userId);
    final asignaturasCollection = userDocument.collection('asignaturas');
    final asignaturasSnapshot = await asignaturasCollection.get();

    List<Asignatura> asignaturas = [];
    asignaturas = asignaturasSnapshot.docs.map((doc) {
      final asignaturaData = doc.data();
      return Asignatura.fromMap({
        ...asignaturaData,
        'id': doc.id, // Agregar el ID del documento
      });
    }).toList();
    return asignaturas;
  }

  Future<void> eliminarTarea(String userId, String tareaId) async {
   
    final tareasDocument = _usersCollection.doc(userId);
    final tareasColections = tareasDocument.collection('tareas');
    await tareasColections.doc(tareaId).delete();
  }

  Future<void> eliminarAsignatura(String userId, String asignaturaId) async {
   
    final asignaturasDocument = _usersCollection.doc(userId);
    final asignaturasCollection = asignaturasDocument.collection('asignaturas');
    await asignaturasCollection.doc(asignaturaId).delete();
  }

  Future<void> actualizarTarea(String userId, Tarea tarea) async {
 
    final tareasDocument = _usersCollection.doc(userId);
    final tareasCollection = tareasDocument.collection('tareas');
    await tareasCollection.doc(tarea.id).update(tarea.toMap());
  }
  Future<void> actualizarAsignatura(String userId, Asignatura asignatura) async {
   
    final asignaturasDocument = _usersCollection.doc(userId);
    final asignaturasCollection = asignaturasDocument.collection('asignaturas');
    await asignaturasCollection.doc(asignatura.id).update({
      'nombre': asignatura.nombre,
      'color': asignatura.color.toString(), // Guardar el color como un entero
    });
  }
}
