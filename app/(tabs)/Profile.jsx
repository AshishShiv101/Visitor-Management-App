import { View, Text, TouchableOpacity, StyleSheet } from 'react-native';
import { Ionicons } from '@expo/vector-icons';  // Importing Ionicons

export default function Profile() {
  return (
    <View style={styles.container}>
      <View style={styles.card}>
        <Text style={styles.name}>Ranbir Kapoor</Text>
        <Text style={styles.contact}>+1234567890</Text>
      </View>

      <TouchableOpacity style={styles.option}>
        <View style={styles.optionContent}>
          <Text style={styles.optionTitle}>Profile Details</Text>
          <Ionicons name="chevron-forward" size={24} color="#333" />
        </View>
      </TouchableOpacity>

      <TouchableOpacity style={styles.option}>
        <View style={styles.optionContent}>
          <Text style={styles.optionTitle}>Device & Credentials</Text>
          <Ionicons name="chevron-forward" size={24} color="#333" />
        </View>
      </TouchableOpacity>

      <TouchableOpacity style={styles.deleteButton}>
        <Text style={styles.deleteText}>Logout</Text>
      </TouchableOpacity>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#F8F9FA',
    padding: 24,
  },
  card: {
    backgroundColor: '#FFFFFF',
    borderRadius: 8,
    paddingVertical: 16,
    paddingHorizontal: 24,
    marginBottom: 24,
    marginTop:50,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 8,
    elevation: 4,
  },
  name: {
    fontSize: 28,
    fontWeight: '700',
    color: '#333',
  },
  contact: {
    fontSize: 16,
    color: '#666',
    marginTop: 8,
  },
  option: {
    backgroundColor: '#FFFFFF',
    borderRadius: 8,
    marginBottom: 16,
    paddingVertical: 16,
    paddingHorizontal: 24,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 8,
    elevation: 4,
  },
  optionContent: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
  },
  optionTitle: {
    fontSize: 18,
    fontWeight: '600',
    color: '#333',
  },
  optionSubtitle: {
    fontSize: 14,
    color: '#666',
    marginTop: 4,
  },
  deleteButton: {
    backgroundColor: '#FF6B6B',
    borderRadius: 8,
    marginTop: 24,
    paddingVertical: 16,
    paddingHorizontal: 24,
    alignItems: 'center',
  },
  deleteText: {
    fontSize: 16,
    fontWeight: '600',
    color: '#FFFFFF',
  },
});
