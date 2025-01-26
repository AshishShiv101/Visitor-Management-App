import { View, Text,ScrollView } from 'react-native';
import React from 'react';
import TopCard from '../../components/Home/TopCard';
import History from '../../components/Home/History';

export default function index() {
  return (
    <ScrollView>

    <View style={styles.container}>
      <Text style={styles.title}>Visitor Message</Text>
      <TopCard />
      <History />
    </View>
    </ScrollView>
  );
}

const styles = {
  container: {
    flex: 1,
    backgroundColor: '#f5f5f5',
    paddingTop: 20,
  },
  title: {
    fontSize: 28,
    fontWeight: 'bold',
    color: '#333',
    textAlign: 'center',
    marginBottom: 20,
  },
};

{/* <Redirect href={'login'}/> */}